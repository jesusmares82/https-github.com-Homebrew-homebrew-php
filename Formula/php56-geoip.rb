require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geoip < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/geoip'
  url 'https://pecl.php.net/get/geoip-1.1.0.tgz'
  sha256 '82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9'
  head 'https://svn.php.net/repository/pecl/geoip/trunk/'

  bottle do
    revision 1
    sha256 "bf1d6f7ef9fe26c1598e44c24d9bf771d3b5ffe5f8ab22f7dbaeb6c7f4e8dd48" => :el_capitan
    sha256 "f940c414c46cb8ce9ec1f0f2f0f83c001719e37bd7490742df2edb6201d5c35e" => :yosemite
    sha256 "838f7ef86e987f79d0a16c2b1b851e8bab567310263669723ba2dcc5c86ec131" => :mavericks
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
