require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Pickle < AbstractPhpPhar
  init
  desc "Installs PHP extensions easily on all platforms."
  homepage "https://github.com/FriendsOfPHP/pickle"
  url "https://github.com/FriendsOfPHP/pickle/releases/download/v0.4.0/pickle.phar"
  version "0.4.0"
  sha256 "d666ca81fde5ecb3881e603edd8f656fbd967cf98c82c2fd9c16fc64e0d4f9a5"

  bottle do
    cellar :any_skip_relocation
    sha256 "4ef0c8c8f7d09abd81ec02b7b6f180ded72e1cce55eab4cb93d324266bf04da3" => :sierra
    sha256 "180239d0570178a678c1a87f0129cfbedb8eec4f5ab06ef0438a3b2508940107" => :el_capitan
    sha256 "e636aec9f97d5a6ec0dff9825eb0887244a622a96b281c0f133e6942783527aa" => :yosemite
    sha256 "2cde74cec0aa6e0a8b27995f89e41b7c30bc6df09d9a3ed965db065afc62c3b3" => :mavericks
  end

  test do
    system "pickle", "--version"
  end
end
