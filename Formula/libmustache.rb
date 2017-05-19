class Libmustache < Formula
  desc "C++ implementation of Mustache."
  homepage "https://github.com/jbboehr/libmustache"
  url "https://github.com/jbboehr/libmustache.git",
      :tag => "v0.4.3",
      :revision => "081952948f6e50f0eeb116fd652585813f31a2ab"

  bottle do
    cellar :any
    sha256 "d682ca1be6e0528710a85ce581fd009f4e28a28fc29c2070a8d2e90273e5b92e" => :sierra
    sha256 "20d0dd1ccd77e7d4da10386eb4e66ac41dac71911c77937da71852ae984a7397" => :el_capitan
    sha256 "6e5796a42374e97fd7ecc05485001430f62127e510b449c6f7200d22c9f5cb8e" => :yosemite
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
