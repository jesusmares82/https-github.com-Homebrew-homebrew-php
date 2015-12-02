require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Chdb < AbstractPhp54Extension
  init
  desc "A fast database for constant data with memory sharing across processes"
  homepage "https://pecl.php.net/package/chdb"
  url "https://pecl.php.net/get/chdb-1.0.2.tgz"
  sha256 "ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b"
  bottle do
    cellar :any
    sha256 "3eb62cf9d79087080998b62112d03ee315e0541b47b247aeb2679486f186509d" => :el_capitan
    sha256 "f399ee2c505fcbf2e11fc8011f2944ff7e125f1d4f2f2890dcfb2fa0e4d26dce" => :yosemite
    sha256 "ecfaa7c408ea9e2f67570afeca3701541635d18605e9ba343987e8dbc802b25c" => :mavericks
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
