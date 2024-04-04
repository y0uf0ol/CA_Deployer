resource "azuread_named_location" "trusted_ip" {
  display_name = "IP Named Location"
  ip {
    ip_ranges = [
      "1.1.1.1/32",
      "2.2.2.2/32",
    ]
    trusted = true
  }
}

resource "azuread_named_location" "trusted_location" {
  display_name = "Country Named Location"
  country {
    countries_and_regions = [
      "US",
      "DE",
    ]
    include_unknown_countries_and_regions = false
  }
}


resource "azuread_named_location" "block_location" {
  display_name = "Block Country Named Location"
  country {
    countries_and_regions = [
      "RU",
    ]
    include_unknown_countries_and_regions = false
  }
}

output "trusted_ip_id" {
  value = azuread_named_location.trusted_ip.id
}  


output "trusted_location_id" {
  value = azuread_named_location.trusted_location.id
}  


output "block_location_id" {
  value = azuread_named_location.block_location.id
}
