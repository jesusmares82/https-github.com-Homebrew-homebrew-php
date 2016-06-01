require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timecop < AbstractPhp53Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4765db24b90f63ab4a68751aa1f802e21a35afddc9e75934ff6dfdd79951ab2c" => :el_capitan
    sha256 "b47f87582e5fea2f3b869e85534b0246815f9d6f023591bfb1c0e746d90e22ec" => :yosemite
    sha256 "84d48040fd892e8f93ef3cf488560d66b52bbf720885bd1d61e29afbb369b378" => :mavericks
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
