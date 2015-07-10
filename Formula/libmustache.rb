class Libmustache < Formula
  desc "C++ implementation of Mustache."
  homepage "https://github.com/jbboehr/libmustache"
  url "https://github.com/jbboehr/libmustache/archive/v0.3.2.tar.gz"
  sha256 "b74e5fed678572a5d8a02fced60bf1c2d9cbe8d432346f0803161280400d93ef"

  bottle do
    cellar :any
    sha256 "2bfdc15117dd4ffd1c50a2c7ec32ec06f11e0a44780d5c0b70ce70d49e145f92" => :yosemite
    sha256 "6e380f2c33b36992b49673caa8108059b3853d4348305f7009355925a9c08772" => :mavericks
    sha256 "96c194eeda6e194bf7e40560fe1fad5e41162cac0ae73c774d0de9d31294cd96" => :mountain_lion
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
