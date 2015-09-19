require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Chdb < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/chdb'
  url 'https://pecl.php.net/get/chdb-1.0.2.tgz'
  sha256 'ac6360fd786fbbbe8b14c7e1943f2f64c1f9a86dd5a4c38ff4d5d65740e99e0b'
  bottle do
    cellar :any
    sha256 "484744697647bc9c20082c242b88167fc118f6e5de490ea35c4fb906806826ff" => :el_capitan
    sha256 "4d7b92955069af9405cd139c1da1f6d6a362e0f96a63ab84a28281939830f25b" => :yosemite
    sha256 "b8c007795175b983bd2e14e903a68abac5417c932c7411ce811af964f69573b4" => :mavericks
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
