require File.expand_path("../../language/php", __FILE__)
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Terminus < Formula
  include Language::PHP::Composer

  desc "Command-line interface for the Pantheon Platform"
  homepage "https://github.com/pantheon-systems/terminus"
  url "https://github.com/pantheon-systems/terminus/archive/1.7.1.tar.gz"
  sha256 "d5d870d8f2a654c74f8c391cd8eddd8a0c8d173ab58363cdc7537273c02dd022"
  head "https://github.com/pantheon-systems/terminus.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f5eb5dd60efe5c1342fda55f0bf765e227794f84a0dbb50f9714495e98511716" => :high_sierra
    sha256 "c76543347e7faac9456e10578a9599353b80525eb2bc35897067828834fd7653" => :sierra
    sha256 "8fa28e4adbca94445455a6ef558f483b75630e2e09a1157b600b1cce388eec9d" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def install
    composer_install

    prefix.install Dir["*"]
  end

  test do
    system bin/"terminus", "self:info", "--field=terminus_version"
  end
end
