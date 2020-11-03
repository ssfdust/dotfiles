is_vgl_enabled() {
  vstatus=$(hostnamectl | awk "/Virtual/ {print \$2} ")
  if [[ -f /usr/lib/libvglfaker.so && -f /usr/lib64/libvglfaker.so && "$vstatus" == "vmware" ]]; then
    echo "enabled"
  else
    echo "disabled"
  fi
}
