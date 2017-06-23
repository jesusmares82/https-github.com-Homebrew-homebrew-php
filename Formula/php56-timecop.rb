require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timecop < AbstractPhp56Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b14264e92279d6c6a2d2f0499f693a1c9e6f23306f62aa8cd082a1d5c1b3dba1" => :sierra
    sha256 "dc9c0ff5faeee8b05a470d05c55ce4cd1dacbea1b7ff1ddb25035df2f868ee48" => :el_capitan
    sha256 "3f6550b14cf71b8a28f99e01e206f124cc12c99c2f764df74f268c61fe4fcb11" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
