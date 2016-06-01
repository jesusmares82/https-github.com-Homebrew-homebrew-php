require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timecop < AbstractPhp55Extension
  init
  desc "timecop is providing \"time travel\" capabilities."
  homepage "https://github.com/hnw/php-timecop"
  url "https://github.com/hnw/php-timecop/archive/v1.1.2.tar.gz"
  sha256 "b25399067862b1f1ff1e52e36a915dad25832f44628c09fa09bad4a7606fb0ed"
  head "https://github.com/hnw/php-timecop.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c95ad5849da5495c167e0ef64cab39df0ef9ed4582f9c27be875b5ddb1dfdec" => :el_capitan
    sha256 "70b22c22b1b15b9c5cc0715f940cfd0c8f9febd0436773d10fc00538cd8c129f" => :yosemite
    sha256 "c6d19c4457f3de07f2401e2321ee09fd5e196bfa0520e48b928f00cc27d959ee" => :mavericks
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
