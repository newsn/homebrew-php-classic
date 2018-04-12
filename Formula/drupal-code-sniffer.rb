require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class DrupalCodeSniffer < Formula
  desc "Checks Drupal code against coding standards"
  homepage "https://drupal.org/project/coder"
  url "https://ftp.drupal.org/files/projects/coder-8.x-2.12.tar.gz"
  version "8.x-2.12"
  sha256 "2890e9bffa085512a0e80a42ddde6356457a9ba3271aefc397e1db5b271d6d67"
  head "http://git.drupal.org/project/coder.git", :branch => "8.x-2.x"

  bottle do
    cellar :any_skip_relocation
    sha256 "303aba612880aba1c64a5b9b1ae55364ba8545e7943017bc9209f3a66c9e1308" => :sierra
    sha256 "303aba612880aba1c64a5b9b1ae55364ba8545e7943017bc9209f3a66c9e1308" => :el_capitan
    sha256 "303aba612880aba1c64a5b9b1ae55364ba8545e7943017bc9209f3a66c9e1308" => :yosemite
  end

  option "without-drupalpractice-standard", "Don't install DrupalPractice standard"

  depends_on "php-code-sniffer"
  depends_on PhpMetaRequirement

  def phpcs_standards
    Formula["php-code-sniffer"].phpcs_standards
  end

  def drupal_standard_name
    "Drupal"
  end

  def drupalpractice_standard_name
    "DrupalPractice"
  end

  def install
    prefix.install "coder_sniffer"
  end

  def post_install
    # Link Drupal Coder Sniffer into PHPCS standards.
    phpcs_standards.mkpath
    if File.symlink? phpcs_standards+drupal_standard_name
      File.delete phpcs_standards+drupal_standard_name
    end
    phpcs_standards.install_symlink prefix+"coder_sniffer"+drupal_standard_name

    # Link DrupalPractice Sniffer into PHPCS standards if not disabled.
    if build.with? "drupalpractice-standard"
      phpcs_standards.mkpath
      if File.symlink? phpcs_standards+drupalpractice_standard_name
        File.delete phpcs_standards+drupalpractice_standard_name
      end
      phpcs_standards.install_symlink prefix+"coder_sniffer"+drupalpractice_standard_name
    end
  end

  def caveats
    <<~EOS
    Drupal Coder Sniffer is linked to "#{phpcs_standards+drupal_standard_name}".

    You can verify whether PHP Code Sniffer has detected the standard by running:

      #{Formula["php-code-sniffer"].phpcs_script_name} -i

    EOS
  end

  test do
    system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupal_standard_name}"
    if build.with? "drupalpractice-standard"
      system "#{Formula["php-code-sniffer"].phpcs_script_name} -i | grep #{drupalpractice_standard_name}"
    end
  end
end
