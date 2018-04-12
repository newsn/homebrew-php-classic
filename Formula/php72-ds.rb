require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ds < AbstractPhp72Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.2.4.tar.gz"
  sha256 "c080bb08445fe690da2271ff866602cf27cadee529ab1a1edbf4aa7a1d6e104c"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0789774de4f65ecc8ce40ab4abe0916ca2be66aa3bd4c9c718c313da8300a251" => :high_sierra
    sha256 "35dfe329fe45b255687ca34ca84ed063e67792abff96cbcbc26f095f78711ee6" => :sierra
    sha256 "1d7f711dcd2eee9e5e078ddef2736196c0a4df2eef7e7f399e170d8dc56e83fb" => :el_capitan
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
