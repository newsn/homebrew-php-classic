require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

module Language
  module PHP
    module Composer
      def self.included(base)
        base.depends_on "composer" => :build
      end

      def composer(*args)
        # No interaction is possible during brew commands
        args.unshift("--no-interaction")

        if ARGV.verbose?
          args.unshift("--verbose")
        end

        system "composer", *args
      end

      def composer_config_github_api_token
        # Configure the Github API token if we have one and no token is configured yet
        if ENV["HOMEBREW_GITHUB_API_TOKEN"] and !(quiet_system "composer", "--no-interaction", "config", "github-oauth.github.com")
          # We don't want to expose the token in the terminal
          ohai "composer config github-oauth.github.com <HOMEBREW_GITHUB_API_TOKEN>".strip
          Homebrew._system "composer", "--no-interaction", "config", "github-oauth.github.com", ENV["HOMEBREW_GITHUB_API_TOKEN"]
        end
      end

      def composer_install(*args)
        # Use a token for install to get around API rate limit
        composer_config_github_api_token
        composer "install", *args
      end
    end
  end
end
