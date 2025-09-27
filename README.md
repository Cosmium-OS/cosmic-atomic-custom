# cosmic-atomic-custom

### Failed akmod build when using this image as a base

Add these lines before doing builds of desired akmods:

```bash
mkdir -p /var/tmp
chmod 1777 /var/tmp
```

It failed for us too when trying to do so ([GitHub Actions log](https://github.com/Cosmium-OS/Cosmium/actions/runs/18039795497/job/51338161434#step:2:3059)), and seems like that was the case for secureblue too when building necessary NVIDIA akmods ([`installnvidiakmod.sh` from their repo](https://github.com/secureblue/secureblue/blob/b513e8e565c9b9d32913cf3992272155e5f7f558/files/scripts/installnvidiakmod.sh#L18)).

Other than that, the system itself works just fine.
