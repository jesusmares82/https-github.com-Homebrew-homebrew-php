require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geoip < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 1
    sha256 "35d967f742a1c2fc8b3ee44bbd1931bcb95999ae1e2b4d2076fc9b5fca3992a3" => :el_capitan
    sha256 "2b14c40d30aca547ee24722cb9cf43b0130dd1838fd9e04295d3d05a458c9b06" => :yosemite
    sha256 "eb0a73aa325472aba86572f2077af1b29159fac23206932ca42923c54f6bab4d" => :mavericks
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
