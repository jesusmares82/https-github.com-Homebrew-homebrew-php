require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geoip < AbstractPhp55Extension
  init
  homepage 'https://pecl.php.net/package/geoip'
  url 'https://pecl.php.net/get/geoip-1.1.0.tgz'
  sha1 '72475f10cb3549eac7d790ab6ae1869f89c6dae0'
  head 'https://svn.php.net/repository/pecl/geoip/trunk/'

  bottle do
    sha256 "26561a3dc6f824fee0c479b6f9c2152cf313e72adc7c4babb7fc5c28cd4cfc6e" => :yosemite
    sha256 "f5a71f0650f0d19b610af98d36aa5325ccda800b082f98c2ad3fb4b958cb65aa" => :mavericks
    sha256 "03913f34fe42ae36db99e5f28d9b400a3cabd716df86bd1d1eaeb6ca5b270caf" => :mountain_lion
  end

  depends_on 'geoip'

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula['geoip'].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
