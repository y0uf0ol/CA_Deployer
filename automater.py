import json
from logging import exception
import requests
from msgraph import GraphServiceClient
from azure.identity import ClientSecretCredential
import argparse
from msgraph.generated.models.conditional_access_policy import ConditionalAccessPolicy
from msgraph.generated.models.conditional_access_condition_set import ConditionalAccessConditionSet
from msgraph.generated.models.risk_level import RiskLevel
from msgraph.generated.models.conditional_access_client_app import ConditionalAccessClientApp
from msgraph.generated.models.conditional_access_applications import ConditionalAccessApplications
from msgraph.generated.models.conditional_access_users import ConditionalAccessUsers
from msgraph.generated.models.conditional_access_platforms import ConditionalAccessPlatforms
from msgraph.generated.models.conditional_access_device_platform import ConditionalAccessDevicePlatform
from msgraph.generated.models.conditional_access_locations import ConditionalAccessLocations
from msgraph.generated.models.conditional_access_device_states import ConditionalAccessDeviceStates
from msgraph.generated.models.conditional_access_grant_controls import ConditionalAccessGrantControls
from msgraph.generated.models.conditional_access_grant_control import ConditionalAccessGrantControl
from msgraph.generated.models.conditional_access_session_controls import ConditionalAccessSessionControls
from msgraph.generated.models.cloud_app_security_session_control import CloudAppSecuritySessionControl
from msgraph.generated.models.sign_in_frequency_session_control import SignInFrequencySessionControl
from mshgraph.generated.models.authentication_strength import AuthenticationStrengthPolicy
# Variables
client_id = 'b54a95cc-1744-4531-beca-6d040d9a5b62'#input("Enter your appliction ID: ")
client_secret = 'OTz8Q~fR0fa5s5kAIuaVpeB4vcYoTVqzX~A7ja0j'#input("Enter your secret sauce: ")
tenant_id = 'e0c0089e-139c-46e7-a82f-231cd621849e'#input("Enter your tenant ID: ")
users_url = "https://graph.microsoft.com/v1.0/users"
ca_url = "https://graph.microsoft.com/beta/identity/conditionalAccess/policies"
grp_url = "https://graph.microsoft.com/v1.0/groups"
scopes = ['https://graph.microsoft.com/.default']
grp_dict = {}
user_dict = {}
## Hardcoded Shit cause im a lazy fuck
persona_groups = [
    "CA-Persona-Admin",
    "CA-Persona-Internals",
    "CA-Persona-Guests",
    "CA-Persona-Breakglass",
    "CA-Persona-ADSync",
]
breakglass_accounts = ["Panic-Button-Provisioner", "All-Access-Pass"]

# Define Arguments for script run
parser = argparse.ArgumentParser()
parser.add_argument(
    "--P1", help="Takes the P1 Conditional Access Set", action="store_true"
)
parser.add_argument(
    "--P2", help="Takes the P2 Conditional Access Set", action="store_true"
)
parser.add_argument(
    "-d",
    "--domain",
    type=str,
    help="Set the Primary Domain you want to push to",
    required=True,
)

args = parser.parse_args()

# Define the domain
domain = args.domain
print(f"Your defined Domain is: {domain}")
# Create a ServicePrincipalCredentials object
credentials = ClientSecretCredential(
    client_id=client_id, client_secret=client_secret, tenant_id=tenant_id
)
# Create a Graph client
graph_client = GraphServiceClient(credentials, scopes)


# Creating base protection groups
def create_group(group_name):
    print("Creating group " + group_name)
    grp = graph_client.post(
        grp_url,
        json={
            "description": group_name,
            "displayName": group_name,
            "groupTypes": [],
            "mailNickname": group_name,
            "mailEnabled": False,
            "securityEnabled": True,
        },
    )
    return grp


def create_breakglass(breakglass_name):
    print("Creating Breakglass Account" + breakglass_name)
    break_user = graph_client.post(
        users_url,
        json={
            "accountEnabled": True,
            "displayName": breakglass_name,
            "mailNickname": breakglass_name,
            "userPrincipalName": breakglass_name + "@" + domain,
            "passwordProfile": {
                "forceChangePasswordNextSignIn": True,
                "password": "SecurePassword123",
            },
        },
    )
    return break_user


def ca_deployment(ca_set):
    # Create a new policy
    print("Creating new policy")
    for cap in ca_set:
        re = requests.get(cap).json()
        graph_client.post(ca_url, json=re)


def ca_breakglass_creation():
# Create a new ConditionalAccessPolicy object
    policy = ConditionalAccessPolicy(
        display_name="CA001-BreakGlas01-BaseProtection-AllApps-AllPlatforms-PhishingResistantMFA",
        state="enabledForReportingButNotEnforced"
    )

# Set the conditions
    conditions = ConditionalAccessConditionSet(
        user_risk_levels=[],
        sign_in_risk_levels=[],
        client_app_types=["all"],
        service_principal_risk_levels=[]
    )

# Set the applications
    applications = ConditionalAccessApplications(
        include_applications=["All"],
        exclude_applications=[],
        include_user_actions=[],
        include_authentication_context_class_references=[]
    )
    conditions.applications = applications

# Set the users
    users = ConditionalAccessUsers(
        include_users=[],
        exclude_users=[],
        include_groups=[grp_dict["CA-Persona-Breakglass"]],
        exclude_groups=[],
        include_roles=[],
        exclude_roles=[]
    )
    conditions.users = users

# Set the locations
    locations = ConditionalAccessLocations(
        include_locations=["All"],
        exclude_locations=["AllTrusted"]
    )
    conditions.locations = locations

    policy.conditions = conditions

# Set the authentication strength
    authentication_strength = AuthenticationStrengthPolicy(
        allowed_combinations=["windowsHelloForBusiness", "fido2", "x509CertificateMultiFactor"],
        combination_configurations=[],
        display_name="Phishing-resistant MFA",
        description="Phishing-resistant, Passwordless methods for the strongest authentication, such as a FIDO2 security key",
        requirements_satisfied="mfa"
    )

# Set the grant controls
    grant_controls = ConditionalAccessGrantControls(
        operator="OR",
        built_in_controls=[],
        custom_authentication_factors=[],
        terms_of_use=[],
        authentication_strength=authentication_strength
    )
    policy.grant_controls = grant_controls

# Create the policy
    created_policy = graph_client.identity.conditional_access.policies.create(policy)

    print("Created policy:", created_policy.id)
def ca_adsync_creation():
    pass


def ca_global_creation():
    pass


def ca_admin_creation():
    pass


def ca_internals_creation():
    pass


def ca_guests_creation():
    pass


# Collect all Base Protection Policies

for group in persona_groups:
    try:
        create_group(group)
        # get all created groupd IDs
        get_grp = graph_client.get(grp_url).json()
        for g in get_grp["value"]:
            if g["displayName"] == group:
                print("\033[92mGroup " + group + " created with ID \033[0m" + g["id"])
                grp_dict[g["displayName"]] = g["id"]
    except Exception as e:
        print(f"\033[91mTError ocurred while creating group '{group}': {str(e)}\033[0m")

for user in breakglass_accounts:
    try:
        create_breakglass(user)
        get_user = graph_client.get(users_url).json()
        for u in get_user["value"]:
            if u["displayName"] == user:
                print("\033[92mUser " + user + " created with ID \033[0m" + u["id"])
                user_dict[u["displayName"]] = u["id"]
    except Exception as e:
        print(f"\033[91mError ocurred while creating user '{user}': {str(e)}\033[0m")

ca_breakglass_creation()
print("\033[96mDONE\033[0m")
