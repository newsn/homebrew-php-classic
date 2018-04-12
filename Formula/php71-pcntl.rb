require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 20

  bottle do
    cellar :any_skip_relocation
    sha256 "ae624cb8e059aa609eaeb697597483fe07da66a533d0dd75c0d0712beff6aa37" => :high_sierra
    sha256 "17009071cf76a6d91195006bae0ebfb0caa02403b042d0b956b3ee004827ac23" => :sierra
    sha256 "fae1ef13626aac7ca40c5a2fc8be27cef692ed152711b2a61bc986d368bc7e94" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
