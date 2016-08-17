require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timecop < AbstractPhp71Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
