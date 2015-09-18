require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Chdb < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/chdb'
  url 'http://pecl.php.net/get/chdb-1.0.2.tgz'
  sha256 'ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b'
  bottle do
    cellar :any
    sha256 "dc3abc586cf4df47c010015dcaeead5eedc0d4c97b29d4039bf2084e1d7a03f1" => :el_capitan
    sha256 "e0fd3b7cc2e85636683e655189b661e0fdf3971b5d8b6fa81f27ce4b9cf860a6" => :yosemite
    sha256 "007e9dc9b1ffd62dcc82ed78c1f5b39ade4173b74962be6340db2728005e77ad" => :mavericks
  end

  head 'https://github.com/lcastelli/chdb', :using => :git

  depends_on 'libcmph'

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
