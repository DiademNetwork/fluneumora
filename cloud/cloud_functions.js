const logger = Moralis.Cloud.getLogger();

Moralis.Cloud.beforeSave("PolygonNFTTransfers", async (request) => {
  try {
    const isNew = request.object.isNew()

    if (isNew) {
      logger.info('beforeSave isNew true')
  
      var isMintTransaction = request.object.get('from_address').toLowerCase().replace(/0/g, '') == 'x'
      logger.info(`beforeSave isMintTransaction ${isMintTransaction}`)
  
      if (!isMintTransaction) {
        const fromAddress = request.object.get('from_address').toLowerCase()
        logger.info(`beforeSave fromAddress ${fromAddress}`)
  
        const fromUserQuery = new Moralis.Query(Moralis.User)
        fromUserQuery.equalTo("address", fromAddress)
    
        const fromUser = await fromUserQuery.first({useMasterKey: true})
        logger.info(`beforeSave fromUser ${fromUser}`)
  
        request.object.set('from_user', fromUser)
      }
    
      const toAddress = request.object.get('to_address').toLowerCase()
      logger.info(`beforeSave toAddress ${toAddress}`)
  
      const toUserQuery = new Moralis.Query(Moralis.User)
      toUserQuery.equalTo("address", toAddress)
    
      const toUser = await toUserQuery.first({useMasterKey:true})
      logger.info(`beforeSave toUser ${toUser}`)
  
      request.object.set('to_user', toUser)
    } else {
      logger.info('beforeSave isNew false')
    }
  } catch (err) {
    logger.info(`beforeSave error ${err}`)
  }
})

Moralis.Cloud.afterSave("PolygonNFTTransfers", async (request) => {
  try {
    const isNew = request.object.isNew()

    if (isNew) {
      logger.info('afterSave isNew true')
    } else {
      logger.info('afterSave isNew false')
    }

    const isMintTransaction = request.object.get('from_address').toLowerCase().replace(/0/g, '') == 'x'
    logger.info (`afterSave isMintTransaction ${isMintTransaction} \n`)
  
    const transactionHash = request.object.get('transaction_hash').toLowerCase()
    logger.info(`afterSave transactionHash ${transactionHash} \n`)
  
    const fromAddress = request.object.get('from_address').toLowerCase()
    logger.info(`afterSave fromAddress ${fromAddress} \n`)
  
    const toAddress = request.object.get('to_address').toLowerCase()
    logger.info(`afterSave toAddress ${toAddress} \n`)
    
    const tokenId = request.object.get('token_id')
    logger.info(`afterSave tokenId ${tokenId} \n`)
  
    const amount = request.object.get('amount')
    logger.info(`afterSave amount ${amount} \n`)

    const depositAddress = ""
    logger.info(`depositAddress ${depositAddress}`)

    const isTransferDepositTransaction = toAddress == depositAddress
    logger.info(`isTransferDepositTransaction ${isTransferDepositTransaction}`)

    const isAcceptDepositTransaction = fromAddress == depositAddress
    logger.info(`isAcceptDepositTransaction ${isAcceptDepositTransaction}`)

    if  (isTransferDepositTransaction) {
      const secret = Array.from(transactionHash).reduce((hash, char) => 0 | (31 * hash + char.charCodeAt(0)), 0)
      logger.info(`secret ${secret}`)

      const sender = fromAddress
      logger.info(`sender ${sender}`)

      const receiver = ""
      logger.info(`receiver ${receiver}`)

      const depositObject = new Moralis.Object("TransferDeposits")

      depositObject.set('token_id', tokenId)
      depositObject.set('amount', amount)
      depositObject.set('sender', sender)
      depositObject.set('receiver', receiver)
      depositObject.set('secret', secret)

      depositObject.save(null, { useMasterKey: true })
    }

    // there is no clear way to find the deposit here to associate with recipient
    // if (isAcceptDepositTransaction) {
    //   var depositQuery = new Moralis.Query("TransferDeposits")

    //   depositQuery.equalTo("amount", amount);

    // deposit.set("receiver", toAddress)
    // }
  
    if (isMintTransaction) {
      var tokenDetailsQuery = new Moralis.Query("TokenDetails")
  
      tokenDetailsQuery.equalTo("hash", transactionHash)
  
      var tokenDetails = await tokenDetailsQuery.first({ useMasterKey: true })
  
      logger.info(`afterSave tokenDetails ${tokenDetails.attributes} \n`)
  
      if (tokenDetails) {
        tokenDetails.set('token_id', tokenId)
        tokenDetails.set('token_supply', amount)
  
        tokenDetails.save(null, {useMasterKey: true})
      }
    }
  
    // no need to update tokens of sender user - if he sending tokens means he already happened to add token before
    if (!isMintTransaction) {
      const fromUserQuery = new Moralis.Query(Moralis.User)
      fromUserQuery.equalTo("address", fromAddress)
  
      const fromUser = await fromUserQuery.first({useMasterKey: true})
  
      logger.info(`afterSave fromUser.attributes.tokens ${fromUser.attributes.tokens}`)

      if (fromUser.attributes.tokens instanceof Array) {
        if (fromUser.attributes.tokens.indexOf(tokenId) == -1) {
          var tokensUpdated = [
            tokenId,
            ...fromUser.attributes.tokens
          ]
          
          logger.info(`afterSave tokensUpdated ${tokensUpdated}`)
          
          fromUser.set('tokens', tokensUpdated)

          fromUser.save(null, { useMasterKey: true})
        } else {
          logger.info(`afterSave fromUser.attributes.tokens already contains ${tokenId}`)
        }
      } else {
        fromUser.set('tokens', [tokenId])

        fromUser.save(null, { useMasterKey: true})
      }
    }
  
    // if (!isDepositTransaction) {
      var toUserQuery = new Moralis.Query(Moralis.User)
      toUserQuery.equalTo("address", toAddress)
    
      const toUser = await toUserQuery.first({useMasterKey:true})
    
      logger.info(`afterSave toUser.attributes ${toUser.attributes}`)
    
      if (toUser.attributes.tokens instanceof Array) {
        if (toUser.attributes.tokens.indexOf(tokenId) === -1) {
          var tokensUpdated = [tokenId, ...toUser.attributes.tokens]
  
          logger.info(`afterSave tokensUpdated ${JSON.stringify(tokensUpdated)}`)
  
          toUser.set('tokens', tokensUpdated)
  
          toUser.save(null, { useMasterKey: true })
        } else {
          logger.info(`afterSave toUser.attributes.tokens already contains ${tokenId}`)
        }
      } else {
        toUser.set('tokens', [tokenId])
      
        toUser.save(null, { useMasterKey: true })
      }
    // }
  } catch (err) {
    logger.info(`afterSave error ${err}`)
  }
})