require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Geoip < AbstractPhp54Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 2
    sha256 "d67cdcbbd882142575fa13fa90c7fcfb2854a9ec2d00e2eb2bb164947a606ecb" => :el_capitan
    sha256 "28cfb1780cf21581fd6eae2e862124c3634015fad1b542423e57ab573ae9ebc0" => :yosemite
    sha256 "a326d52b42dd05c5b35aeb0e9861f678c149d6c9d3c098677cd7e59064e8ee34" => :mavericks
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
