require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaz < AbstractPhp53Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"

  bottle do
    sha256 "37a96725df6f5c6aa24637876100b37687329e08b9e94200d0a2970e3116edaf" => :el_capitan
    sha256 "fb98ff02e5f24b8180462492e93275c9df3cbff6ee3446f3da7745696e81a09b" => :yosemite
    sha256 "43883dae77b7ecaaef72b7f09223b97a53e4a80508c945d284e88b4c182a4574" => :mavericks
  end

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
