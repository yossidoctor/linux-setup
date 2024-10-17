```bash
git clone https://github.com/yossidoctor/linux-setup.git
rsync -av --exclude='.git' --exclude='README.MD' linux-setup/ ./
sh setup.sh
```
