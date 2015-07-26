require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any
    sha256 "9418b3539ad56af832a6814698f51ab9b8510a4d47c78de59beac7077f50e906" => :yosemite
    sha256 "1fd919d02d2cb6c22889774c92882971c4123f43e5c284edfa7972a8b0d1cccd" => :mavericks
    sha256 "2614609c47bf85aa9d9cbc86813b22402444c07ecae881d6ef8a3f82747b3d2f" => :mountain_lion
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("pcntl")
  end
end

