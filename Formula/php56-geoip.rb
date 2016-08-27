require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Geoip < AbstractPhp56Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.1.tgz"
  sha256 "b2d05c03019d46135c249b5a7fa0dbd43ca5ee98aea8ed807bc7aa90ac8c0f06"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 2
    sha256 "35d973a2d4c3708f146d87494956cce5d009da76a3b86ec8d644525edb7933d3" => :el_capitan
    sha256 "685ae7510fbe6a0fd98d75fd1c42f59d3cceeedf86eca4853cdbdb640b18f3c2" => :yosemite
    sha256 "649e3c1ae8a69ed266eafd3dae740ef60f915986a1c74d77ff4aaac847d2d153" => :mavericks
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
