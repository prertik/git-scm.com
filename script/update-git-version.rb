#!/usr/bin/env ruby

# This is a simple Ruby script to update the Git version in _config.yml

require "octokit"
require "yaml"
require_relative "version"

octokit = Octokit::Client.new(access_token: ENV.fetch("GITHUB_API_TOKEN", nil))
tags = octokit.tags("git/git")
    .map { |item| item.first[1] }
    .select { |tag| tag =~ /^v\d+(\.\d+){2,3}$/ } # filter out e.g. -rc versions
    .sort_by { |tag| -Version.version_to_num(tag) }
version = tags[0].gsub(/^v/, "")

ref = octokit.ref("git/git", "tags/#{tags[0]}")
tag = octokit.tag("git/git", ref.object.sha)
date = tag.tagger.date

config = YAML.load_file("_config.yml")
config["latest_version"] = version
config["latest_relnote_url"] = "https://raw.github.com/git/git/master/Documentation/RelNotes/#{version}.txt"
config["latest_release_date"] = date.strftime("%Y-%m-%d")
yaml = YAML.dump(config).gsub(/ *$/, "")
File.write("_config.yml", yaml)