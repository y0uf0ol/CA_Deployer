# Azure AD Security Configuration
This project automates the setup of security configurations in Azure Active Directory using Terraform.
Prerequisites

## An Azure AD application registration with the following permissions:

- Application.Read.All
- Directory.Read.All
- Domain.Read.All
- Group.ReadWrite.All
- GroupMember.Read.All
- Policy.Read.All
- Policy.ReadWrite.AuthenticationMethod
- Policy.ReadWrite.Authorization
- Policy.ReadWrite.ConditionalAccess
- User.Read
- User.ReadWrite.Al