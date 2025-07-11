#!/usr/bin/env ruby

release_url = 'https://archive.mozilla.org/pub/fenix/releases/'

require 'open-uri'

release_raw = URI.open(release_url).read

# Find versions
# THe line looks like <td><a href="/pub/fenix/releases/125.0b7/">125.0b7/</a></td>
ver_line_re = %r{\s*<td><a href="[^"]*">([\d.]+)/?</a></td>}
versions = release_raw.scan(ver_line_re).flatten.uniq

# Find the latest version
# First, parse as major.minor(.patch)

def parse_ver(version)
  vs = version.split('.').map(&:to_i)
  vs << 0 while vs.length < 3
  vs[0..2] # Return only major, minor, and patch
end

def compare_versions(ver1, ver2)
  v1_parts = parse_ver(ver1)
  v2_parts = parse_ver(ver2)

  0.upto 2 do |i|
    if v1_parts[i] > v2_parts[i]
      return 1
    elsif v1_parts[i] < v2_parts[i]
      return -1
    end
  end

  0
end

versions.sort! { |a, b| compare_versions(b, a) }

latest_version = versions.first

# Write to file
File.write 'latest_ff.out', latest_version
