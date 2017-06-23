require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timecop < AbstractPhp70Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.2.4.tar.gz"
  sha256 "1e0bc0b47097500152aab0cd8fbc7f4b1323816cdbcd1b65df639d95356fbf85"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f3e70aa0bb4c7ffd5b8d9fb8dd2e9fc78410d366a06f02258cc64995d5b7f188" => :sierra
    sha256 "c0ab989c1ab4efe5ce139d64ab214336317a20a660686683bf06ed20ed300738" => :el_capitan
    sha256 "fc52e0001526de43f2dc5ba4f61d30a36a41a2b956e22a6f016a87ec2ac0ebd5" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/timecop.so"
    write_config_file if build.with? "config-file"
  end
end
