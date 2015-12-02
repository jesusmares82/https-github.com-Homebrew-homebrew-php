require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Geoip < AbstractPhp55Extension
  init
  desc "Map IP address to geographic places"
  homepage "https://pecl.php.net/package/geoip"
  url "https://pecl.php.net/get/geoip-1.1.0.tgz"
  sha256 "82c6deb7264d2ff7c4d6c45a7d27cff7ab097be965795e317e04a9c5b7be98b9"
  head "https://svn.php.net/repository/pecl/geoip/trunk/"

  bottle do
    revision 2
    sha256 "de82ed09346a961a41e1120e58d38c8adf379f57ac48d3783f3497958bb09410" => :el_capitan
    sha256 "45bda3a8e3e5b8d063c970e020e61d24f6100161a4c7b9356c239e1eb9a20310" => :yosemite
    sha256 "c455d9969fcd385b868ea5c25f42bdbb76a6ed8307868259e7a451238e8a6462" => :mavericks
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
