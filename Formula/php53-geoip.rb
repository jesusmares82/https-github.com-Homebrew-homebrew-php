require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Geoip < AbstractPhp53Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 1
    sha256 "25ec91e52bc5c54c6ae75cf085dd89b3f0fc7c26c25cbad630e6cc17ed5dee81" => :el_capitan
    sha256 "bfadb3ad9c6ef9e73b92c8ce0795248471a559c45748c61a7bf4392ab5d40be0" => :yosemite
    sha256 "7e8d0701ed324751175f04cb9795f02985620715bd668524399e7c586e902155" => :mavericks
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
