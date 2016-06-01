require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timecop < AbstractPhp54Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bfcaa1554ed51c0cd51d1ffe1249ac5523077f87182728dc2d2ec553bcb19a60" => :el_capitan
    sha256 "aabd9d8aaae79c7fc5aeccf10c57d0ccd817fef0337ba5bdf202a94540deda62" => :yosemite
    sha256 "f0a73309b5e234a9b6c258c68334555dedefeed00b35401336a26a36985e89ed" => :mavericks
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
