require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Geoip < AbstractPhp53Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    sha256 "25f695e659ff6f390f54dc608eed6224346ab56315569452626840d5110c0fb5" => :yosemite
    sha256 "6c3f7ca3d6901cd1b3a8a25409e3470818b734abadc634f7a74b30c7ddc646e3" => :mavericks
    sha256 "2df677d40f47d2042dc6ee6de86e709d51cc20071440d3fc1526dd7ec280f4ab" => :mountain_lion
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
