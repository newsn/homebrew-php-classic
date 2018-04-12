class Libmustache < Formula
  desc "C++ implementation of Mustache"
  homepage "https://github.com/jbboehr/libmustache"
  url "https://github.com/jbboehr/libmustache.git",
      :tag => "v0.4.4",
      :revision => "f9b9d977a2804a0cf8d849e2fd50e1516289a6e7"

  bottle do
    cellar :any
    sha256 "3af03a8f0b637e35813a650abb9c361f4e84b92eab32f318788dea492265128a" => :high_sierra
    sha256 "d9c3204502644fab9c23c093f6ba2166f9d45ea1bfa233ec700ee6d8b3738b3c" => :sierra
    sha256 "e7cf2e411b188f5b07fef4cb911f81553b22fe28261763f6b6de1c25a555bc63" => :el_capitan
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS
    #include <mustache/mustache_config.h>
    #include <mustache/mustache.hpp>
    int main() {
        mustache::Mustache m;
        mustache_version_int();
        return 0;
    }
    EOS
    system ENV.cxx, "-std=c++11", "-c", "-o", (testpath/"test.o"), (testpath/"test.cpp")
    system ENV.cxx, "-std=c++11", "-o", (testpath/"test"), (testpath/"test.o"), "-lmustache"
    system (testpath/"test")
  end
end
