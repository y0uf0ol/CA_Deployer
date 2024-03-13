import json
from logging import exception
import requests
from msgraph.core import GraphClient
import msgraph.core
from azure.identity import ClientSecretCredential
import argparse
#Variables
client_id = 'b54a95cc-1744-4531-beca-6d040d9a5b62'#input('Enter your appliction ID: ')
client_secret = 'tI28Q~wEny9QnAbSxOyBU5846XwHSpmW7GJWja~x'#input('Enter your client secret: ')
tenant_id = 'e0c0089e-139c-46e7-a82f-231cd621849e'#input('Enter your tenant ID: ')
users_url = 'https://graph.microsoft.com/v1.0/users'
ca_url = 'https://graph.microsoft.com/beta/identity/conditionalAccess/policies'
grp_url = 'https://graph.microsoft.com/v1.0/groups'
grp_dict = {}
user_dict = {}
## Hardcoded Shit cause im a lazy fuck
persona_groups = ['CA-Persona-Admin','CA-Persona-Internals','CA-Persona-Guests','CA-Persona-Breakglass','CA-Persona-ADSync']
breakglass_accounts = ['Panic-Button-Provisioner','All-Access-Pass']

# Define Arguments for script run
parser = argparse.ArgumentParser()
parser.add_argument("--P1", help="Takes the P1 Conditional Access Set", action="store_true")
parser.add_argument("--P2", help="Takes the P2 Conditional Access Set", action="store_true")
parser.add_argument("-d","--domain",type=str, help="Set the Primary Domain you want to push to", required=True)

args = parser.parse_args()

# Define the domain
domain = args.domain 
print(f"Your defined Domain is: {domain}")
# Create a ServicePrincipalCredentials object
credentials = ClientSecretCredential(
    client_id=client_id,
    client_secret=client_secret,
    tenant_id=tenant_id
)
# Create a Graph client
graph_client = GraphClient(credential=credentials)

# Creating base protection groups
def create_group(group_name):
    print('Creating group ' + group_name)
    grp = graph_client.post(grp_url, json={
                                                    "description": group_name, 
                                                    "displayName": group_name, 
                                                    "groupTypes": [], 
                                                    "mailNickname": group_name, 
                                                    "mailEnabled": False, 
                                                    "securityEnabled": True})
    return grp


def create_breakglass(breakglass_name):
    print("Creating Breakglass Account" + breakglass_name)
    break_user = graph_client.post(users_url, json={  
                                                    "accountEnabled": True,
                                                    "displayName": breakglass_name,
                                                    "mailNickname": breakglass_name,
                                                    "userPrincipalName": breakglass_name+'@'+domain,
                                                    "passwordProfile": {
                                                    "forceChangePasswordNextSignIn": True,
                                                    "password": "SecurePassword123"}
                                                    })
    return break_user

def ca_deployment(ca_set):
    #Create a new policy
    print('Creating new policy')
    for cap in ca_set:
        re = requests.get(cap).json()
        graph_client.post(ca_url, json=re)     
    
def ca_breakglass_creation():
    ca_set = []
    # modify policy CA001 and CA002 with breakglass user

    ca_deployment(ca_set)

    pass

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
        #get all created groupd IDs
        get_grp = graph_client.get(grp_url).json()
        for g in get_grp['value']:
            if g['displayName'] == group:
                print('\033[92mGroup ' + group + ' created with ID \033[0m' + g['id'])
                grp_dict[g['displayName']] = g['id']
    except Exception as e:
        print(f"\033[91mTError ocurred while creating group '{group}': {str(e)}\033[0m")

for user in breakglass_accounts:
    try:
        create_breakglass(user)
        get_user = graph_client.get(users_url).json()
        for u in get_user['value']:
            if u['displayName'] == user:
                print('\033[92mUser ' + user + ' created with ID \033[0m' + u['id'])
                user_dict[u['displayName']] = u['id']
    except Exception as e:
        print(f"\033[91mError ocurred while creating user '{user}': {str(e)}\033[0m")


print("\033[96mDONE\033[0m")  
