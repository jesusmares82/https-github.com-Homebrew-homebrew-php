require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timecop < AbstractPhp71Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0c12c552994fdeb05958be1f998dc17a93115b083313d3b45e3e60fc027bb1b7" => :el_capitan
    sha256 "05251322c44757940324136300da08ee550c3f2aff0116590b99b70c88cfb41f" => :yosemite
    sha256 "c8fbc2caeb4274a8fd56d2b4e5d2f36d512381061bbc0d65b406c00db21794ac" => :mavericks
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
