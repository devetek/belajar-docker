# Dasar Docker (ENTRYPOINT vs CMD)

## ENTRYPOINT

ENTRYPOINT menentukan perintah yang akan selalu dieksekusi ketika image dimulai.

## CMD

Jika ENTRYPOINT diset CMD menentukan argumen yang akan dimasukkan ke ENTRYPOINT.

Atau, jika ingin membuat image untuk tujuan umum, dapat dengan tidak melakukan memasukkan nilai pada ENTRYPOINT dan hanya menggunakan CMD, misal ["./bash"] karena Anda akan dapat menimpa pengaturan dengan memberikan argumen untuk menjalankan docker.

## Build

```sh
make build

make build TAG=entry

make build TAG=cmd
```

## Test

```sh
make test-cmdentry

make test-cmd

make test-entry
```

## Referensi

[Stuckoverflow](https://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile).