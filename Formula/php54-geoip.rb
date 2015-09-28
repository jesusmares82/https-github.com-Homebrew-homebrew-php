require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geoip < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 1
    sha256 "7211d8412f93ff21690c8eb61b9f1b368cf46733be095196e5954ad004d0fb08" => :el_capitan
    sha256 "7a9d2ca4d513b0cda4d0b95705eb7dad75314f7f01ea6339c6656e79485cf0d2" => :yosemite
    sha256 "474bcf8be449dcef0cdf51952c5f9da2d14e6b33b089b5232dcad3bc09a5ec24" => :mavericks
  end

  depends_on "geoip"

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula["geoip"].opt_prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file if build.with? "config-file"
  end
end
