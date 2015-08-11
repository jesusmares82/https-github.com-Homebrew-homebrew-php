require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geoip < AbstractPhp56Extension
  init
  homepage 'http://pecl.php.net/package/geoip'
  url 'http://pecl.php.net/get/geoip-1.1.0.tgz'
  sha1 '72475f10cb3549eac7d790ab6ae1869f89c6dae0'
  head 'https://svn.php.net/repository/pecl/geoip/trunk/'

  bottle do
    sha256 "b7038c1d20725b7be54012ffce6d1f043f17c9c77ed13638827cb86607048276" => :yosemite
    sha256 "d4ef426ac4a6e650cde9c72b9afafbb6f61f8bbd8efa56c0ac321cd4bc9f0008" => :mavericks
    sha256 "fda2debb41dd029d6ae82dc75a7bb98e2230f00d2dda97305a8f968a0a3bd2cc" => :mountain_lion
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
