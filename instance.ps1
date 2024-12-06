$InstanceParams = @{
    ImageId        = "ami-12345678" # Replace with your AMI ID
    InstanceType   = "t2.micro"
    KeyName        = "my-key-pair"  # Replace with your key pair name
    MinCount       = 1
    MaxCount       = 1
}

$Instance = New-EC2Instance @InstanceParams
$Instance.Instances | Select-Object InstanceId, State, PublicDnsName
