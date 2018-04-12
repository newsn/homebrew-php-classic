class AbstractPhpVersion < Formula
  module PhpdbgDefs
    PHPDBG_SRC_TARBALL = "https://github.com/krakjoe/phpdbg/archive/v0.3.2.tar.gz".freeze
    PHPDBG_CHECKSUM    = {
      :sha256 => "feab6e29ef9a490aa53332fe014e8026d89d970acc5105f37330b2f31e711bbd",
    }.freeze
  end

  module Php53Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.3.29.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.3.29".freeze
    PHP_BRANCH      = "PHP-5.3".freeze

    PHP_CHECKSUM    = {
      :sha256 => "c4e1cf6972b2a9c7f2777a18497d83bf713cdbecabb65d3ff62ba441aebb0091",
    }.freeze
  end

  module Php54Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.4.45.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.4.45".freeze
    PHP_BRANCH      = "PHP-5.4".freeze

    PHP_CHECKSUM    = {
      :sha256 => "4e0d28b1554c95cfaea6fa2b64aac85433f158ce72bb571bcd5574f98f4c6582",
    }.freeze
  end

  module Php55Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.5.38.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.5.38".freeze
    PHP_BRANCH      = "PHP-5.5".freeze

    PHP_CHECKSUM    = {
      :sha256 => "473c81ebb2e48ca468caee031762266651843d7227c18a824add9b07b9393e38",
    }.freeze
  end

  module Php56Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-5.6.33.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "5.6.33".freeze
    PHP_BRANCH      = "PHP-5.6".freeze

    PHP_CHECKSUM    = {
      :sha256 => "07f696a9761dcd839e2045c95c3a4d2ffb52c54417477cca9d30a14975b831cc",
    }.freeze
  end

  module Php70Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.0.27.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.0.27".freeze
    PHP_BRANCH      = "PHP-7.0".freeze

    PHP_CHECKSUM    = {
      :sha256 => "99fa2563bb4c4c1cde9febe87cfe97324227d7b4b8828f2e936e507127394131",
    }.freeze
  end

  module Php71Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.1.14.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.1.14".freeze
    PHP_BRANCH      = "PHP-7.1".freeze

    PHP_CHECKSUM    = {
      :sha256 => "63b2fd139ed7656756b0fa290bc42f8fff854723c3d2710a700e646370c581f4",
    }.freeze
  end

  module Php72Defs
    PHP_SRC_TARBALL = "https://php.net/get/php-7.2.2.tar.bz2/from/this/mirror".freeze
    PHP_GITHUB_URL  = "https://github.com/php/php-src.git".freeze
    PHP_VERSION     = "7.2.2".freeze
    PHP_BRANCH      = "PHP-7.2".freeze

    PHP_CHECKSUM    = {
      :sha256 => "f841ac58e17471f2241ea892b34edb01dc9b93ad9f661ffe4e3f1f476a8f4aee",
    }.freeze
  end
end
