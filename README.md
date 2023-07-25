# Azure Conditional Access Automator

This Python script automates the process of creating and managing Conditional Access Policies in Azure. It uses the Microsoft Graph API to interact with Azure Active Directory and Conditional Access Policies.

## Features

- **Group Creation**: The script creates Azure AD groups based on a predefined list. These groups can be used in Conditional Access Policies for targeting specific users.
- **Policy Collection**: The script collects a list of Base Protection Policies from a predefined GitHub repository. These policies are used as templates for creating new Conditional Access Policies.
- **Policy Creation**: The script creates new Conditional Access Policies in Azure based on the collected Base Protection Policies.

## Usage

1. Run the script.
2. When prompted, enter your Azure Application ID, Client Secret, and Tenant ID.
3. The script will create the necessary Azure AD groups, collect the Base Protection Policies, and create new Conditional Access Policies.

## Prerequisites

- Python 3.6 or later
- `requests` Python library
- `msgraph.core` Python library
- `azure.identity` Python library

## Required Azure API Permissions

The script requires the following Azure API permissions:

- **Application.Read.All**: Allows the app to read all applications.
- **Directory.ReadWrite.All**: Allows the app to read and write directory data.
- **Group.ReadWrite.All**: Allows the app to read and write all groups.
- **GroupMember.ReadWrite.All**: Allows the app to read and write all group memberships.
- **Policy.Read.All**: Allows the app to read your organization's policies.
- **Policy.ReadWrite.ConditionalAccess**: Allows the app to read and write your organization's conditional access policies.
- **User.Read.All**: Allows the app to read all users' full profiles.

Ensure that these permissions are granted in the Azure portal before running the script. You can do this by registering an app in Azure AD and assigning the necessary permissions to it.

## Contributing

Contributions to this project are welcome. If you have a suggestion or find a bug, please open an issue on GitHub.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

