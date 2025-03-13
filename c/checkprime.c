int checkprime(int n){
    for(int i = 2; i<n; i++)
    {
        if(n%i == 0)
            return 0;
        else
            continue;
    }

    return n;
}