class Libmustache < Formula
  desc "C++ implementation of Mustache."
  homepage "https://github.com/jbboehr/libmustache"
  url "https://github.com/jbboehr/libmustache.git",
      :tag => "v0.4.2",
      :revision => "13103f9ec494b1ff23bba02228bca229ecf42f6c"

  bottle do
    cellar :any
    sha256 "53bcf4c67512f00d27e4a16f55c4e8f496a195a0fcd7bffa544fa211eb3b6b41" => :sierra
    sha256 "1752f44c30a728271c23cd3c52be8b60645aef932187ab3673c2b4a09dbe9af7" => :el_capitan
    sha256 "937826c1b7b51d2d789669223d5aad4ee334abe5f989ac3d05e78702e7353f65" => :yosemite
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
