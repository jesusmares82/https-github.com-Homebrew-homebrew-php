require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timecop < AbstractPhp70Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f919c8e8223baded31046c6eebefdf5b74914f264b943f50171721812b5377c0" => :el_capitan
    sha256 "296020671882b21a92b997e63ec5b6481191c9d7c12bd9ed7a35f1dfede36026" => :yosemite
    sha256 "c68114b3c085226fd13f42f7949abe0b12f4a0656746d8b24dbad5d5347e95ed" => :mavericks
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
