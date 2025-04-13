//// This is a tool designed to retrieve the Address Resolution Protocol (ARP)
//// cache and perform IP address lookups corresponding to given MAC addresses.
////
//// As it stands, this utility functions exclusively on the Erlang target platform.
//// Windows users are also out of luck with this package.

import gleam/list
import gleam/option.{Some}
import gleam/regexp
import gleam/string

pub type ArpEntry {
  ArpEntry(ip: String, mac: String, interface: String)
}

@external(erlang, "next_door_ffi", "arp_table")
fn get_arp_table() -> String

/// Get an ARP table from the ARP cache.
pub fn arp_table() {
  parse_table(get_arp_table())
}

/// Convert an mac address to an IP address. The mac address is case insensitive
pub fn mac_to_ip(table: List(ArpEntry), mac: String) {
  let mac = string.lowercase(mac)
  use entry <- list.find_map(table)
  case entry.mac == mac {
    True -> Ok(entry.ip)
    False -> Error(Nil)
  }
}

/// Parse a string of BSD style arp entries in a list of arp entries.
pub fn parse_table(table: String) {
  let assert Ok(reg) =
    regexp.from_string("\\(\\K([^\\)]*)\\) at (\\S+) on (\\w+)")

  use match <- list.try_map(regexp.scan(reg, table))
  case match {
    regexp.Match(_, [Some(ip), Some(mac), Some(interface)]) ->
      Ok(ArpEntry(ip:, mac:, interface:))
    _ -> Error(Nil)
  }
}
