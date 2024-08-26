from mitmproxy import ctx

def load(loader):
    ctx.options.view_filter = "~d authsamples|cognito"
