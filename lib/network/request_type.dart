enum RequestType {
  post("POST"),
  get("GET"),
  put("PUT"),
  delete("DELETE"),
  patch("PATCH"),
  copy("COPY"),
  head("HEAD"),
  options("OPTIONS"),
  link("LINK"),
  unlink("UNLINK"),
  purge("PURGE"),
  lock("LOCK"),
  unlock("UNLOCK"),
  view("VIEW");

  final String value;

  const RequestType(this.value);
}
