require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Chdb < AbstractPhp55Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    sha256 "c29e62f9b5d67ae902df6d8b78baad58612ea04be5be5b0317138c2a0e735338" => :el_capitan
    sha256 "70987c24a1fa9ece79823b63d21a594e4f0251e6799c5595fd9794ff63631c30" => :yosemite
    sha256 "f666a9fd5d16c4a3fb0f3535214d6b704cc946374b71fda61b22df445ecaee9a" => :mavericks
  end

  head "https://github.com/lcastelli/chdb", :using => :git

  depends_on "libcmph"

  def install
    Dir.chdir "chdb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/chdb.so"
    write_config_file if build.with? "config-file"
  end
end
