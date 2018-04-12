require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Suhosin < AbstractPhp56Extension
  init
  desc "Suhosin is an advanced protection system for PHP installations."
  homepage "https://suhosin.org/stories/index.html"
  url "https://github.com/sektioneins/suhosin/archive/0.9.38.tar.gz"
  sha256 "c02d76c4e7ce777910a37c18181cb67fd9e90efe0107feab3de3131b5f89bcea"
  head "https://github.com/stefanesser/suhosin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "077fd5a259af184e56cb79c9db74765f3798d44dcc1636c2a291c1aeeb46b7ee" => :sierra
    sha256 "826ce479fce7e50f87e8c4db4ef0a808024940b29cc503439594d9350e86187b" => :el_capitan
    sha256 "1004c9537a2c3478e3391624e50c734a7da0789af9985350471c72a08a6ae7ec" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/suhosin.so"
    write_config_file if build.with? "config-file"
  end
end
