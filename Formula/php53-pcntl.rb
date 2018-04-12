require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pcntl < AbstractPhp53Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "66a303c157eb59da5abdf4589fdbc4e7068a4f8fbff6007f53be827254b99e13" => :el_capitan
    sha256 "ddb6723c8feec642b9b3d277d3b438eb5fccd026f1f104c659d6feda5decdc82" => :yosemite
    sha256 "cb5984ea33012e34b7dac3d7cab9122446027b2d3f2e136bff9ae822aa12b3b6" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
