function sa() {
    pat="$*"
    alias | grep -E "$pat"
}
