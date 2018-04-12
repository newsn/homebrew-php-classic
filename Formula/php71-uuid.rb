require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Uuid < AbstractPhp71Extension
  init
  desc "UUID extension"
  homepage "https://pecl.php.net/package/uuid"

  stable do
    url "https://pecl.php.net/get/uuid-1.0.4.tgz"
    sha256 "63079b6a62a9d43691ecbcd4eb52e5e5fe17b5a3d0f8e46e3c17ff265c06a11f"

    patch do
      # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
      # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
      url "https://gist.githubusercontent.com/romainneutron/fe068c297413aee565d5/raw/28d6ba0b6e902e82e71bb9a1ed768c836a8161e4/php-uuid-1.0.4"
      sha256 "5f0664d5c4f55d4f6c037dab9f198e697afa3f9266854ed3945d7697fdb692b2"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "ab1f3636c3a0c7fd026a39a1d5f5ebe088fe6e28076ce88c8a13b067cb981b12" => :el_capitan
    sha256 "95d3212fb55d4dcf5c67740757fa7ffa22542ad3cd8bcf5b3d07a05f663af952" => :yosemite
    sha256 "c22f027d7ece0ce7d1b1cc28776ba903abd9800ca43313350c122b4a16f333bd" => :mavericks
  end

  head do
    url "https://git.php.net/repository/pecl/networking/uuid.git"

    patch do
      # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
      # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
      url "https://gist.githubusercontent.com/romainneutron/059b5795d205640ebf5a/raw/3ccec57f9a960ee04e4c2f9d80b16ab070d0fe65/php-uuid-master"
      sha256 "4025b2e99032b447fcf244dacac7fdeb601b3aa40204a3cdd9e475c5c2fa15cd"
    end
  end

  depends_on "ossp-uuid"

  def install
    Dir.chdir "uuid-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uuid.so"
    write_config_file if build.with? "config-file"
  end
end
