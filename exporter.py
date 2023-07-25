import json
import requests
from msgraph.core import GraphClient
import msgraph.core
from azure.identity import ClientSecretCredential
#Variables
client_id = input('Enter your appliction ID: ')
client_secret = input('Enter your client secret: ')
tenant_id = input('Enter your tenant ID: ')
users_url = 'https://graph.microsoft.com/v1.0/users'
ca_url = 'https://graph.microsoft.com/beta/identity/conditionalAccess/policies'
grp_url = 'https://graph.microsoft.com/v1.0/groups'


# Create a ServicePrincipalCredentials object
credentials = ClientSecretCredential(
    client_id=client_id,
    client_secret=client_secret,
    tenant_id=tenant_id
)
# Create a Graph client
graph_client = GraphClient(credential=credentials)

# Creating base protection groups

# Collect all Base Protection Policies
print('Collecting Base Protection Policies')

#Get all policies
policies = graph_client.get(ca_url).json()

for policy in policies['value']:
    name=(policy['displayName'])
    json_object = json.dumps(policy)
    print(name)
    f=open(name+".json",'w+')
    f.write(json_object)


